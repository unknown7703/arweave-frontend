import "@/styles/globals.css";
import * as React from "react";
import type { AppProps } from "next/app";
import Layout from "../components/layout/layout";
import { RecoilRoot } from "recoil";

export default function App({ Component, pageProps }: AppProps) {
  return (
    <RecoilRoot>
      <Layout>
        <Component {...pageProps} />
      </Layout>
    </RecoilRoot>
  );
}
