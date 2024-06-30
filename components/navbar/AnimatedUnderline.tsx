import { Animated, PanResponder, StyleSheet, View } from "react-native";
import React, { useEffect, useRef } from "react";
import { Coordinate } from "../interface/Coordinate.ts";
import { AnimatedUnderlineProps } from "../interface/AnimatedUnderlineProps.tsx";

export function callUseEffectForUnderlineTab(previousPan: Animated.ValueXY,prevCoordinate:Coordinate) {
    useEffect(() => {
        Animated.timing(previousPan, {
            toValue: prevCoordinate,
            duration: 350,
            useNativeDriver: true,
        }).start();
    }, [previousPan]);
    return (
      <AnimatedUnderline height={100} panX={previousPan.x} panY={previousPan.y} pan={previousPan}/>
    )
}

export const AnimatedUnderline: React.FC<AnimatedUnderlineProps> = (
  { height, panX, panY,pan}) => {
    return(
      <Animated.View style={underlineStyles(height,panX,panY).underline} />
    )
};

const underlineStyles = (height: number, panX: Animated.AnimatedValue, panY: Animated.AnimatedValue) => StyleSheet.create({
    underline: {
        position: "absolute",
        left: 17,
        top: height,
        right: 0,
        width: 50,
        height:3,
        backgroundColor: "white",
        transform: [{translateX: panX},  {translateY: panY}]
    }
})




