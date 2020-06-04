module DefParser where
import Data.Char
import Text.ParserCombinators.ReadP
import Data.DefinitionIR

parseInt :: ReadP Int
parseInt = read <$> many (satisfy isDigit)

parseSetName :: ReadP String
parseSetName = many (satisfy isAlpha)

parseName :: ReadP [Char]
parseName = string "Name" *> skipSpaces *> many1(satisfy (\x -> (x /= ' ')))

parseSetDef :: ReadP Set
parseSetDef = Set <$> (string "Set" *> parseSetName) <*> parseInt <*> parseInt <*> return (Position [] [])

parseAllSetDefs :: ReadP Set
parseAllSetDefs = sepBy parseSetDef skipSpaces

parseSolvedState :: ReadP SolvedState
parseSolvedState = string "Solved\n" *> 