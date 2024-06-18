import { Animated } from "react-native";

export interface AnimatedUnderlineProps {
  height: number;
  panX: Animated.AnimatedValue;
  panY: Animated.AnimatedValue;
  pan : Animated.ValueXY;
}
