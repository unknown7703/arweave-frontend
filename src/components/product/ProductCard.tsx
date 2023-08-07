import Image from "next/image";
import Link from "next/link";
import { useEffect, useState } from 'react';
import React from 'react';

import Web3Modal from 'web3modal';


const ProductCard:React.FC = () => {
    const [prod, setProd] = useState([])
    const [loadingState, setLoadingState] = useState('not-loaded')
    useEffect(() => {
      loadNFTs()
    }, [])
    async function loadNFTs() {
        const web3Modal = new Web3Modal({
          network: 'mainnet',
          cacheProvider: true,
        })
    }
    return (
        <div>
        <div className="p-4">
          <h2 className="text-2xl py-2">Items Listed</h2>
            <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 pt-4">
            {
              prod.map((prod, i) => (
                <div key={i} className="border shadow rounded-xl overflow-hidden">
                  <img src={prod} className="rounded" />
                  <div className="p-4 bg-black">
                    <p className="text-2xl font-bold text-white">Price - {} Eth</p>
                  </div>
                </div>
              ))
            }
          </div>
        </div>
      </div>
    );
}
export default ProductCard;