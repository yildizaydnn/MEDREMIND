import React, { useState, useEffect, useRef, useCallback, use } from "react";
import {
  View,
  Text,
  ViewStyle,
  Touchable,
  Animated,
  Dimensions,
  SafeAreaView,
  StyleSheet,
} from "react-native";
import { ScrollView } from "react-native";
import { LinearGradient } from "expo-linear-gradient";
import { TouchableOpacity } from "react-native";
import { Ionicons } from "@expo/vector-icons";
import { Colors } from "../constants/Colors";
import Svg, { Circle } from "react-native-svg";
import { Link, useRouter, router } from "expo-router";
const { width } = Dimensions.get("window");

// Create an Animated version of the Circle component
const AnimatedCircle = Animated.createAnimatedComponent(Circle);

const QUICK_ACTIONS = [
  {
    icon: "add-circle-outline" as const,
    label: "Add\nMedication",
    route: "/medication/add" as const,
    color: "#FF9B2F",
    gradient: ["#808836", "#BFEA7C"] as [string, string],
  },
  {
    icon: "calendar-outline" as const,
    label: "Calendar\nView",
    route: "/calendar" as const,
    color: "#FFF0BD",
    gradient: ["#FF9A00", "#EAD8A4"] as [string, string],
  },
  {
    icon: "time-outline" as const,
    label: "History\nLog",
    route: "/history" as const,
    color: "#FF9B2F",
    gradient: ["#803D3B", "#FF9B2F"] as [string, string],
  },
  {
    icon: "medical-outline" as const,
    label: "Refill\nTracker",
    route: "/refill" as const,
    color: "#FF9B2F",
    gradient: ["#FB4141", "#FF9B2F"] as [string, string],
  },
];

interface CicularProgressProps {
  progress: number;
  totalDoses: number;
  completedDoses: number;
}

function CircularProgress({
  progress,
  totalDoses,
  completedDoses,
}: CicularProgressProps) {
  const animationValue = useRef(new Animated.Value(0)).current;
  const size = width * 0.55;
  const strokeWidth = 15;
  const radius = (size - strokeWidth) / 2;
  const circumference = 2 * Math.PI * radius;

  useEffect(() => {
    Animated.timing(animationValue, {
      toValue: progress,
      duration: 1000,
      useNativeDriver: true,
    }).start();
  }, [progress]);

  const strokeDashoffset = animationValue.interpolate({
    inputRange: [0, 1],
    outputRange: [circumference, 0],
  });

  return (
    <View style={styles.progressContainer}>
      <View style={styles.progressTextContainer}>
        <Text style={styles.progressPercentage}>{Math.round(progress)}%</Text>
        <Text style={styles.progressLabel}>
          {completedDoses} of {totalDoses} doeses
        </Text>
      </View>
      <Svg width={size} height={size} style={styles.progressRing}>
        <Circle
          cx={size / 2}
          cy={size / 2}
          r={radius}
          stroke="rgba(255, 255, 255, 0.2)"
          strokeWidth={strokeWidth}
          fill="none"
        />
        <AnimatedCircle
          cx={size / 2}
          cy={size / 2}
          r={radius}
          stroke="white"
          strokeWidth={strokeWidth}
          fill="none"
          strokeDasharray={circumference}
          strokeDashoffset={strokeDashoffset}
          strokeLinecap="round"
          transform={`rotate(-90 ${size / 2} ${size / 2})`}
        />
      </Svg>
    </View>
  );
}

export default function HomeScreen() {
  const router = useRouter();
  return (
    <ScrollView style={styles.container} showsVerticalScrollIndicator={false}>
      <LinearGradient colors={["#89AC46", "#3F7D58"]} style={styles.header}>
        <View style={styles.headerContent}>
          <View style={styles.headerTop}>
            <View style={{ flex: 1 }}>
              <Text style={styles.greeting}> Daily Progress </Text>
            </View>
            <TouchableOpacity style={styles.notificationButton}>
              <Ionicons name="notifications-outline" size={24} color="white" />
              {
                <View style={styles.notificationBadge}>
                  <Text style={styles.notificationCount}>3</Text>
                </View>
              }
            </TouchableOpacity>
          </View>
          <CircularProgress progress={50} totalDoses={10} completedDoses={5} />
        </View>
      </LinearGradient>

      <View style={styles.content}>
        <View style={styles.quickActionsContainer}>
          <Text style={styles.sectionTitle}>Quick Actions</Text>
          <View style={styles.quickActionGrid}>
            {QUICK_ACTIONS.map((action) => (
              <Link href={"/home"} key={action.label} asChild>
                <TouchableOpacity style={styles.actionButton}>
                  <LinearGradient
                    colors={action.gradient}
                    style={styles.actionGradient}
                  >
                    <View style={styles.actionContent}>
                      <View style={styles.actionIcon}>
                        <Ionicons name={action.icon} size={24} color="white" />
                      </View>
                      <Text style={styles.actionLabel}>{action.label}</Text>
                    </View>
                  </LinearGradient>
                </TouchableOpacity>
              </Link>
            ))}
          </View>
        </View>
      </View>

      <View>
        <View>
          <Text>Today&apos;s Schedule</Text>
          <Link rel="stylesheet" href="/calender">
            <TouchableOpacity>
              <Text>See All</Text>
            </TouchableOpacity>
          </Link>
        </View>

        {true ? (
          <View>
            <Ionicons name="medical-outline" size={48} color="#ccc" />
            <Text>No Medications Scheduled</Text>
            <Link href="/medications/add">
              <TouchableOpacity>
                <Text>Add Medication</Text>
              </TouchableOpacity>
            </Link>
          </View>
        ) : (
          [].map((medications, index) => {
            return (
              <View key={index} style={styles.medicationItem}>
                <View style={styles.medicationIcon}>
                  <Ionicons name="medical" size={24} />
                </View>
                <View style={styles.medicationDetails}></View>
              </View>
            );
          })
        )}
      </View>
    </ScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "white",
  },
  header: {
    paddingTop: 50,
    paddingBottom: 25,
    borderBottomLeftRadius: 30,
    borderBottomRightRadius: 30,
  },
  headerContent: {
    paddingHorizontal: 20,
  },

  headerTop: {
    flexDirection: "row",
    alignItems: "center",
    width: "100%",
    marginBottom: 20,
  },
  greeting: {
    fontSize: 18,
    fontWeight: "600",
    color: "white",
    opacity: 0.8,
  },
  content: {
    flex: 1,
    paddingTop: 20,
  },

  notificationButton: {
    position: "relative",
    padding: 8,
    backgroundColor: "rgba(255, 255, 255, 0.15)",
    borderRadius: 12,
    marginLeft: 8,
  },
  notificationBadge: {
    position: "absolute",
    top: -4,
    right: -4,
    backgroundColor: "#ff5252",
    borderRadius: 100,
    padding: 4,
    height: 20,
    justifyContent: "center",
    alignItems: "center",
    paddingHorizontal: 6,
    borderWidth: 2,
    borderColor: "#146922",
    minWidth: 20,
  },
  notificationCount: {
    fontSize: 8,
    fontWeight: "bold",
    color: "white",
  },

  progressContainer: {
    alignItems: "center",
    justifyContent: "center",
    marginVertical: 10,
  },

  progressTextContainer: {
    position: "absolute",
    alignItems: "center",
    justifyContent: "center",
    zIndex: 1,
  },
  progressPercentage: {
    fontSize: 24,
    color: "white",
    fontWeight: "bold",
  },

  progressLabel: {
    fontSize: 14,
    color: "rgba(255, 255, 255, 0.7)",
    fontWeight: "bold",
  },

  progressRing: {
    transform: [{ rotate: "-90deg" }],
    alignSelf: "center",
  },

  progressDetails: {
    fontSize: 11,
    color: "white",
    fontWeight: "bold",
  },

  quickActionsContainer: {
    paddingHorizontal: 20,
    marginBottom: 25,
  },
  quickActionGrid: {
    flexDirection: "row",
    flexWrap: "wrap",
    gap: 12,
    marginTop: 15,
  },

  actionButton: {
    width: (width - 52) / 2,
    height: 120, // Sabit yükseklik
    borderRadius: 16,
    overflow: "hidden",
  },
  actionGradient: {
    flex: 1,
    padding: 15,
    alignItems: "center",
    justifyContent: "center", // İçeriği ortala
  },
  actionIcon: {
    width: 40,
    height: 40,
    borderRadius: 12,
    backgroundColor: "rgba(255, 255, 255, 0.2)",
    alignItems: "center",
    justifyContent: "center", // İkonu ortala
    marginBottom: 8,
  },
  actionLabel: {
    fontSize: 14,
    color: "white",
    fontWeight: "600",
    textAlign: "center", // Metni ortala
    lineHeight: 18,
  },

  sectionTitle: {
    fontSize: 20,
    fontWeight: "700",
    color: "#1a1a1a",
    marginBottom: 5,
  },
  actionContent: {
    flex: 1,
    justifyContent: "space-between",
  },
});
