/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 */

import React from "react";
import { StyleSheet } from "react-native";
import { MyNavigation } from "./components/navbar/NavigationController";

function App(): React.JSX.Element {
  /**
   * push notification
   */
  return (
     <MyNavigation/>
  );
}

export const iconStyles = (width: number, height: number) => StyleSheet.create({
  icon : {
    width: width,
    height:height
  }
})


export default App;

