# rune-mastery
Comparing runes and masteries of your recent games vs pros.

Simple rails app, only system requirement is redis.

- [X] Display information for last 10 matches instead of just latest
- [X] Compare with top 5 pros instead of just top
- [X] Don't include pros with missing runes (outdated)
- [X] Say which pro we're comparing against
- ~~[ ] Include count of runes shared in RuneComparator#compare (instead of just which ones)~~
- [X] Include 'type' of rune as first class field (Quint, Mark, Glyph, Seal), ~~and bucket comparisons this way~~
- [X] Cache SuccessfulGamesScraper (By Champion)
- [X] Cache static api calls (Champion & Rune lookup)
- [X] Just display rune type in list (`Greater Glyph of Magic Resist` vs `Magic Resist`)
- [ ] Add "Least common" runes. If 4/6 pros don't use Magic Pen Quints for Anivia, show that. But not 2/6?
- [ ] Use a real cache instead of storing in memory
