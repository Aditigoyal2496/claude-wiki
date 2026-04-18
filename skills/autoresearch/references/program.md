# Autoresearch Program — Configuration

Customize these settings to control how `/autoresearch` behaves.

---

## Preferred Sources

List source types in order of preference:
1. Official documentation and primary sources
2. Peer-reviewed research and academic papers
3. Established publications and expert analysis
4. Blog posts from recognized practitioners
5. Community discussions and forums

## Domains to Prefer

- (Add domains you trust, e.g., arxiv.org, official docs sites)

## Domains to Avoid

- (Add domains you don't trust or want to exclude)

## Confidence Rules

- Claims supported by 2+ independent sources → `certainty: high`
- Claims from a single authoritative source → `certainty: medium`
- Claims from blogs, forums, or unverified sources → `certainty: inferred`

## Limits

- Maximum research rounds: 3
- Maximum pages to fetch per round: 5
- Maximum new wiki pages per research session: 8

## Domain-Specific Notes

- (Add any domain-specific research constraints, e.g., "for medical topics, prefer PubMed" or "for financial data, prefer SEC filings")
