/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 */

import React, { useRef, useState } from "react";
import { Animated, Dimensions, Image, PanResponder, StyleSheet, View } from "react-native";

import { createBottomTabNavigator } from "@react-navigation/bottom-tabs";
import { NavigationContainer } from "@react-navigation/native";
import LinearGradient from "react-native-linear-gradient";
import { MatchScreen } from "./components/screen/MatchScreen.tsx";
import { SearchScreen } from "./components/screen/SearchScreen.tsx";
import { NewsScreen } from "./components/screen/NewsScreen.tsx";
import { FavouriteScreen } from "./components/screen/FavouriteScreen.tsx";
import { OtherScreen } from "./components/screen/OtherScreen.tsx";
import { AnimatedUnderline, callUseEffectForUnderlineTab } from "./components/navbar/AnimatedUnderline.tsx";

const Tab = createBottomTabNavigator();

function underlineTabIcon(select:string) {
  const images = {
    match: require("./assets/match_tab.png"),
    search: require("./assets/search_tab.png"),
    news : require("./assets/news_tab.png"),
    favourite: require("./assets/favourite_tab.png"),
    others: require("./assets/others_tab.png"),
  };
  switch (select) {
    case 'match':
      return (
        <View>
          <View>
            <Image
              style={iconStyles(20,15).icon}
              source={images.match}
            />
          </View>
        </View>
      );
    case 'search':
      return (
        <View>
          <Image
            style={iconStyles(20,20).icon}
            source={images.search}
          />
        </View>
      );
    case 'news':
      // setUnderline('news');
      return (
        <Image
          style={iconStyles(20,20).icon}
          source={images.news}
        />
      );
    case 'favourite':
      // setUnderline('favourite');
      return (
        <View>
          <Image
            style={iconStyles(20,20).icon}
            source={images.favourite}
          />
        </View>

      );
    case 'others':
      return (
        <View>
          <Image
            style={iconStyles(4,15).icon}
            source={images.others}
          />
        </View>
      );
    default:
  }
}

function setStatePanX(panX: {}, setPanX: (value: (((prevState: {}) => {}) | {})) => void) {
  setPanX(panX);
}


function setStatePanY(panY: {}, setPanY: (value: (((prevState: {}) => {}) | {})) => void) {
  setPanY(panY);
}



function App(): React.JSX.Element {
  let pan = useRef(new Animated.ValueXY()).current;
  let [underlineTabSelected,setUnderlineTabSelected] = useState('');
  let {height} = Dimensions.get('window')
  height = height - 60;
  return (
      <NavigationContainer>
        <Tab.Navigator screenOptions={{
          headerShown: false,
          tabBarStyle: {
            paddingTop: 8,
            paddingBottom: 15,
            height: 65
          },
          tabBarBackground:() => (
            <LinearGradient colors={['#359DD9','#013A67']} style={{height:65}}/>
          )
        }} screenListeners={({route}) => ({ tabPress:() => {}
        })} >
          <Tab.Screen name="Pertandingan" component={MatchScreen} options={
            {
              tabBarLabelStyle: {
                color: 'white'
              },
              tabBarIcon: ({}) => {
                if(underlineTabSelected=='match') {
                  callUseEffectForUnderlineTab(pan,{"x":0, "y":0})
                }
                return (
                 underlineTabIcon('match')
                )
              }
            }
          } listeners={({route}) => ({ tabPress:() => {
              setUnderlineTabSelected('match');
            }
          })}  />
          <Tab.Screen name="Cari" component={SearchScreen} options={
            {
              tabBarLabelStyle: {
                color: 'white'
              },
              tabBarIcon: ({}) => {
                if(underlineTabSelected=='search') {
                  callUseEffectForUnderlineTab(pan,{"x":85, "y":0})
                }
                return (
                  underlineTabIcon('search')
                )
              }
            }
          } listeners={({route}) => ({ tabPress:() => {
              setUnderlineTabSelected('search');
            }
          })} />
          <Tab.Screen name="Berita" component={NewsScreen} options={
            {
              tabBarLabelStyle: {
                color: 'white'
              },
              tabBarIcon: ({}) => {
                if(underlineTabSelected=='news') {
                  callUseEffectForUnderlineTab(pan,{"x":164, "y":0})
                }
                return underlineTabIcon('news')
              }
            }
          } listeners={()=>({
            tabPress : () => {
              setUnderlineTabSelected('news');
            }
          })} />
          <Tab.Screen name="Favorit" component={FavouriteScreen} options={
            {
              tabBarLabelStyle: {
                color: 'white'
              },
              tabBarIcon: ({}) => {
                if(underlineTabSelected=='favourite') {
                  callUseEffectForUnderlineTab(pan,{"x":246, "y":0})
                }
                return underlineTabIcon('favourite')
              }
            }
          } listeners={()=>({
            tabPress: () => {
              setUnderlineTabSelected('favourite');
            }
          })} />
          <Tab.Screen name="Lainnya" component={OtherScreen} options={
            {
              tabBarLabelStyle: {
                color: 'white'
              },
              tabBarIcon: ({}) => {
                if(underlineTabSelected=='others') {
                  callUseEffectForUnderlineTab(pan,{"x":328, "y":0})
                }
                return underlineTabIcon('others')
              }
            }
          } listeners={()=>({
            tabPress: () => {
              setUnderlineTabSelected('others');
            }
          })}/>
        </Tab.Navigator>
        <AnimatedUnderline height={height} panX={pan.x} panY={pan.y} pan={pan}/>
      </NavigationContainer>
  );
}

export const iconStyles = (width: number, height: number) => StyleSheet.create({
  icon : {
    width: width,
    height:height
  }
})


export default App;

