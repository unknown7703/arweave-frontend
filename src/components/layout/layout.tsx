import React from 'react';
import Navbar from '../navbar/navbar'
const Layout:React.FC<{ children: React.ReactNode }> = ({ children }) => {
    
    return (
        <>
        <Navbar/>
          <main>{children}</main>
        </>    
    );
}
export default Layout;