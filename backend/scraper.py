import httpx
from bs4 import BeautifulSoup
import re

async def scrape_event_website(url: str) -> str:
    """
    Fetches the HTML of an event website and returns a sanitized text
    version suitable for feeding directly into an LLM context.
    """
    async with httpx.AsyncClient(timeout=15.0, follow_redirects=True) as client:
        # Some event websites block default user-agents, spoofing a real browser is crucial
        headers = {
            "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36",
            "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8",
            "Accept-Language": "en-US,en;q=0.5"
        }
        
        response = await client.get(url, headers=headers)
        response.raise_for_status()
        
        soup = BeautifulSoup(response.text, 'html.parser')
        
        # Remove noisy tags to optimize token footprint and cost
        for el in soup(["script", "style", "svg", "img", "nav", "footer", "meta", "link", "noscript", "header"]):
            el.decompose()
            
        # Get raw text
        text = soup.get_text(separator=' ', strip=True)
        # Collapse multiple spaces
        text = re.sub(r'\s+', ' ', text)
        
        # 100,000 characters is a safe limit for a standard website body
        return text[:100000]
