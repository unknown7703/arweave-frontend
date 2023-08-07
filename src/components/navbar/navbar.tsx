import React from "react";
import Link from "next/link";
import Image from "next/image";
import logo from "@#/images/main-logo.png";

type navbarProps = {};

const Navbar: React.FC = () => {
  return (
    <>
      <div className="flex flex-row w-100 bg-white">
        <div className="flex flex-row w-full my-7 text-black">
          <div className="basis-1/3 self-center ">
            <div className="flex justify-start ml-5">
              <div className="flex flex-row items-center gap-5 mt-5 sm:justify-end sm:mt-0 sm:pl-5">
                <a
                  className="font-small text-black hover:text-gray-400"
                  href="#"
                 
                >
                  Find Talent
                </a>
                <a
                  className="font-small text-black hover:text-gray-400 "
                  href="#"
                >
                 For Designers
                </a>
                <a
                  className="font-small text-black hover:text-gray-400 "
                  href="#"
                >
                  Inspiration
                </a>
                <a
                  className="font-small text-black hover:text-gray-400 "
                  href="#"
                >
                 Learn Design
                </a>
                <a
                  className="font-small text-black hover:text-gray-400 "
                  href="#"
                >
               Go Pro
                </a>
              </div>
            </div>
          </div>
          <div className="basis-1/3 self-center ">
            <div className="flex justify-center">
                <Image src={logo} width={50}
      height={50}
      alt="Picture of the author"/>
            </div>
          </div>
          <div className="basis-1/3 self-center">
            <div className="flex justify-center ">03</div>
          </div>
        </div>
      </div>
    </>
  );
};
export default Navbar;
