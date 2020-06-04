module Data.DefinitionIR where 

data CubieProperty = Permutation | Orientation
data Set = Set {name:: String, positions:: Int, orientations:: Int, solved:: Position}
data Position = Position {permutation :: [Int], orientation :: [Int]}
data PositionMask = PositionMask {permMask :: [Bool], orientMask:: [Bool]}
data SetPosition = SetPosition {setName:: String, moveEffect :: Position}
type SolvedState = [SetPosition]
type MoveEffect = [SetPosition]
data MoveName = String
data Move = Move {moveName :: MoveName, effect :: MoveEffect}
data MoveInstance = MoveInstance {baseMove:: Move, rotationCount:: Int, prime:: Bool}
data Ignore = Ignore {ignoredSetName :: String, ignoredFacelets :: PositionMask}
data MoveCombination = MoveCombination {resultMove:: MoveName, components :: [MoveName]}
data PruningTable = PruningTable {prunedSetName :: String, property:: CubieProperty, maxStates:: Int}
type PruningTables = [PruningTable]