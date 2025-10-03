module Ex2 where

rollover :: Int
rollover = 1000000000

add :: OperationFn
add x y = (x + y) `mod` rollover

mul :: OperationFn
mul x y
    | p == 0 = 1
    | otherwise = p
  where
    p = (x * y) `mod` rollover

-- DON'T RENAME THE SPECIFIED TYPES OR FUNCTIONS
-- DON'T MODIFY ANYTHING ABOVE THIS LINE

-- *** Q1,2,3 (8 marks)

-- Hint for Q1,2,3: taking every 3rd element of [1..13] returns [3,6,9,12]

-- *** Q1

-- returns a list of every 390th element of its input
f1 :: [a] -> [a] -- DO NOT CHANGE !
f1 = every 390

-- *** Q2

-- sums every 177th element of its input
-- if list is too short it returns 0
-- you can use `add` or `(+)` here - won't effect grading
f2 :: [Int] -> Int -- DO NOT CHANGE !
f2 ns = Ex2.sum (every 177 ns)

-- *** Q3

-- multiplies every 228th element of its input
-- if list is too short it returns 1
-- you can use `mul` or `(*)` here - won't effect grading
f3 :: [Int] -> Int -- DO NOT CHANGE !
f3 ns =
    let elements = every 288 ns
     in Ex2.product elements

-- *** Q4 (9 marks)

-- Operation Table (See Exercise2 description on BB)
--    ____________________________________________
--    | opcode | operation | operands  | Nothing |
--    --------------------------------------------
--    |   17   |    add    | fixed  3  | term    |
--    |   76   |    add    | fixed  5  | skip    |
--    |   33   |    add    | fixed  3  | 2       |
--    |   16   |    add    | stop@ 15  | term    |
--    |   53   |    add    | stop@ 16  | skip    |
--    |   79   |    add    | stop@ 14  | 9       |
--    |   87   |    mul    | fixed  6  | term    |
--    |   89   |    mul    | fixed  4  | skip    |
--    |   99   |    mul    | fixed  3  | 8       |
--    |   36   |    mul    | stop@ 15  | term    |
--    |   45   |    mul    | stop@ 15  | skip    |
--    |   28   |    mul    | stop@ 15  | 7       |
--    --------------------------------------------
-- initially, skip any number that is not an opcode
-- if called with [], return `(0,[])`
-- if no numbers found after an `add` opcode, return (0,[])
-- if no numbers found after an `mul` opcode, return (1,[])
-- if list ends midway through opcode processing, return result so far
-- if a Nothing is skipped for a fixed N opcode,
--    that Nothing does not contribute to the count.
-- Hint:
--   When building a list for test purposes,
--   remember a value of type `Maybe a` needs to be built
--   using one of the two data constructors of the `Maybe` type.

f4 :: [Maybe Int] -> (Int, [Maybe Int]) -- DO NOT CHANGE !
f4 [] = (0, [])
f4 (Nothing : rest) = f4 rest
f4 (Just x : rest) =
    let handle = handleForRest 0 rest
     in table x handle

data Operand
    = Fixed Int
    | Stop Int
    deriving (Eq, Show)

data NothingMode
    = Term
    | Skip
    | Value Int
    deriving (Eq, Show)

type OperationFn =
    Int -> Int -> Int

type HandlerFn =
    OperationFn -> Operand -> NothingMode -> (Int, [Maybe Int])

table :: Int -> HandlerFn -> (Int, [Maybe Int])
table 17 handle = handle add (Fixed 3) Term
table 76 handle = handle add (Fixed 5) Skip
table 33 handle = handle add (Fixed 3) (Value 2)
table 16 handle = handle add (Stop 15) Term
table 53 handle = handle add (Stop 16) Skip
table 79 handle = handle add (Stop 14) (Value 9)
table 87 handle = handle mul (Fixed 6) Term
table 89 handle = handle mul (Fixed 4) Skip
table 99 handle = handle mul (Fixed 3) (Value 8)
table 36 handle = handle mul (Stop 15) Term
table 45 handle = handle mul (Stop 15) Skip
table 28 handle = handle mul (Stop 15) (Value 7)
table x _ = (x, [])

handleForRest :: Int -> [Maybe Int] -> HandlerFn
-- Handle `Fixed` traversals
-- If we reach 0 on fixed, return immediately
handleForRest acc rest _ (Fixed 0) _ =
    (acc, rest)
-- Apply the `operationFn` and decrement `n`
handleForRest acc (Just x : rest) operationFn (Fixed n) nothingMode =
    let
        next = operationFn x acc
        stopCount = n - 1
     in
        handleForRest next rest operationFn (Fixed stopCount) nothingMode
-- Handle `Stop` traversals
-- Return immediately when the value of stop is found
handleForRest acc (Just x : rest) _ (Stop y) _
    | x == y = (acc, rest)
-- Apply the `operationFn` and recurse if x is not stop
handleForRest acc (Just x : rest) operationFn (Stop y) nothingMode =
    let
        next = operationFn x acc
     in
        handleForRest next rest operationFn (Stop y) nothingMode
-- Handle `Nothing` values
-- Return immediately when `Term` is set
handleForRest acc (Nothing : rest) _ _ Term =
    (acc, rest)
-- Use the immediate next value when `Skip` is set
handleForRest acc (Nothing : x : rest) operationFn operand Skip =
    handleForRest acc (x : rest) operationFn operand Skip
-- Use the value of x when `Value x` is set
handleForRest acc (Nothing : rest) operationFn operand (Value x) =
    handleForRest acc ((Just x) : rest) operationFn operand (Value x)
-- Exit when list empty
handleForRest acc [Nothing] _ _ _ = (acc, [])
handleForRest acc [] _ _ _ = (acc, [])

-- *** Q5 (3 marks)

-- uses `f4` to process all the opcodes in the maybe list,
-- by repeatedly applying it to the leftover part
-- Note: this will be tested against a correct version of `f4`,
--       rather than your submission.
f5 :: [Maybe Int] -> [Int] -- DO NOT CHANGE !
f5 [] = []
f5 xs =
    let (val, rest) = f4 xs
        next = f5 rest
     in val : next

-- add extra material below here
-- e.g.,  helper functions, test values, etc. ...

every :: Int -> [a] -> [a]
every n xs
    | n <= 0 = []
    | otherwise = case drop (n - 1) xs of
        y : ys -> y : every n ys
        [] -> []

sum :: [Int] -> Int
sum [] = 0
sum (x : xs) = add (Ex2.sum xs) x

product :: [Int] -> Int
product [] = 1
product (x : xs) = mul (Ex2.product xs) x
