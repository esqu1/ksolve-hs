module DefParser where

import           Data.Char
import           Data.DefinitionIR
import           Data.Maybe
import           Text.ParserCombinators.ReadP

parseInt :: ReadP Int
parseInt = read <$> many (satisfy isDigit)

parseSetName :: ReadP String
parseSetName = many (satisfy isAlpha)

parseName :: ReadP [Char]
parseName = string "Name" *> skipSpaces *> many1 (satisfy (\x -> (x /= ' ')))

parseSetDef :: ReadP Set
parseSetDef =
  Set <$> (string "Set" *> parseSetName) <*> parseInt <*> parseInt <*>
  return (Position [] (Just []))

parseAllSetDefs :: ReadP [Set]
parseAllSetDefs = sepBy parseSetDef skipSpaces

parseSetPosition :: ReadP SetPosition
parseSetPosition =
  (\x y z -> SetPosition x (Position y z)) <$> parseSetName <*>
  (skipSpaces *> endBy1 parseInt skipSpaces) <*>
  option Nothing (Just <$> endBy1 parseInt skipSpaces)

parseSolvedState :: ReadP SolvedState
parseSolvedState =
  skipSpaces *> string "Solved" *> skipSpaces *>
  sepBy1 parseSetPosition skipSpaces <*
  string "End" <*
  skipSpaces

parseSection :: ReadP Section
parseSection = undefined
