-----------------------------------------------------------------------------
--
-- Solution for Rosetta Code task "Read a configuration file"
-- <http://rosettacode.org/wiki/Read_a_configuration_file)>
--
-----------------------------------------------------------------------------

import Control.Arrow
import Control.Monad
import Data.Char
import Data.Maybe


main = do
    config <- liftM (getPairs . getLines) $ readFile "fruit.cfg"
    let
        fullname = strVal config "fullname"
        favouritefruit = strVal config "favouritefruit"
        needspeeling = boolVal config "needspeeling"
        seedsremoved = boolVal config "seedsremoved"
        otherfamily = lstVal config "otherfamily"
    putStrLn $ "fullname = " ++ show fullname
    putStrLn $ "favouritefruit = " ++ show favouritefruit
    putStrLn $ "needspeeling = " ++ show needspeeling
    putStrLn $ "seedsremoved = " ++ show seedsremoved
    putStrLn $ "otherfamily = " ++ show otherfamily


boolVal config key = isJust $ lookup key config

strVal config key = maybe "" head $ lookup key config

lstVal config key = fromMaybe [] $ lookup key config

getPairs = map ((parseKey *** parseValue) . getPair)
    where
        parseKey = map toLower
        parseValue = map lstrip . split ','
        getPair = span (not . isSep)

getLines content = filter relevant $ map lstrip $ lines content

lstrip = dropWhile isSpace 

relevant [] = False
relevant (c : _) = not $ elem c ['#', ';']

isSep c = elem c [' ', '=']

split _ [] = []
split sep l@(x : xs)
    | x == sep = split sep xs
    | otherwise = prefix : split sep sufix
        where (prefix, sufix) = span (/= sep) l

