{-# LANGUAGE DataKinds #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeApplications #-}

module Cardano.Wallet.DummyTarget.Primitive.Types
    ( DummyTarget
    , block0
    , genesisBlockParameters
    , genesisParameters
    , genesisTxParameters
    , genesisHash
    , mockHash
    , mkTxId
    , mkTx
    ) where

import Prelude

import Cardano.Wallet.Primitive.Types
    ( ActiveSlotCoefficient (..)
    , Block (..)
    , BlockHeader (..)
    , BlockchainParameters (..)
    , Coin (..)
    , EpochLength (..)
    , FeePolicy (..)
    , GenesisBlockParameters (..)
    , Hash (..)
    , SlotLength (..)
    , StartTime (..)
    , Tx (..)
    , TxIn (..)
    , TxOut (..)
    , TxParameters (..)
    , slotMinBound
    )
import Crypto.Hash
    ( Blake2b_256, hash )
import Data.ByteString
    ( ByteString )
import Data.Coerce
    ( coerce )
import Data.Quantity
    ( Quantity (..) )
import Data.Time.Clock.POSIX
    ( posixSecondsToUTCTime )
import Fmt
    ( Buildable (..) )

import qualified Data.ByteArray as BA
import qualified Data.ByteString.Char8 as B8

data DummyTarget

instance Buildable DummyTarget where
    build _ = mempty

genesisHash :: Hash "Genesis"
genesisHash = Hash (B8.replicate 32 '0')

block0 :: Block
block0 = Block
    { header = BlockHeader
        { slotId = slotMinBound
        , blockHeight = Quantity 0
        , headerHash = mockHash slotMinBound
        , parentHeaderHash = coerce genesisHash
        }
    , transactions = []
    , delegations = []
    }

genesisParameters :: BlockchainParameters
genesisParameters = BlockchainParameters
    { getGenesisBlockHash = genesisHash
    , getGenesisBlockDate = StartTime $ posixSecondsToUTCTime 0
    , getSlotLength = SlotLength 1
    , getEpochLength = EpochLength 21600
    , getEpochStability = Quantity 2160
    , getActiveSlotCoefficient = ActiveSlotCoefficient 1
    }

genesisTxParameters :: TxParameters
genesisTxParameters = TxParameters
    { getFeePolicy = LinearFee (Quantity 14) (Quantity 42) (Quantity 5)
    , getTxMaxSize = Quantity 8192
    }

genesisBlockParameters :: GenesisBlockParameters
genesisBlockParameters = GenesisBlockParameters
    { staticParameters = genesisParameters
    , txParameters = genesisTxParameters
    }

-- | Construct a @Tx@, computing its hash using the dummy @mkTxId@.
mkTx :: [(TxIn, Coin)] -> [TxOut] -> Tx
mkTx ins outs = Tx (mkTxId ins outs) ins outs

-- | txId calculation for testing purposes.
mkTxId :: [(TxIn, Coin)] -> [TxOut] -> Hash "Tx"
mkTxId = curry mockHash

-- | Construct a good-enough hash for testing
mockHash :: Show a => a -> Hash whatever
mockHash = Hash . blake2b256 . B8.pack . show
  where
     blake2b256 :: ByteString -> ByteString
     blake2b256 =
         BA.convert . hash @_ @Blake2b_256
