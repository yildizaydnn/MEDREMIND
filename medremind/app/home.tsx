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
import { Modal } from "react-native";

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

      <View style={{ paddingHorizontal: 20 }}>
        <View style={styles.sectionHeader}>
          <Text style={styles.sectionTitle}>Today&apos;s Schedule</Text>
          <Link href="/calender" asChild>
            <TouchableOpacity>
              <Text style={styles.seeAllButton}>See All</Text>
            </TouchableOpacity>
          </Link>
        </View>

        {true ? (
          <View style={styles.emptyStateContainer}>
            <Ionicons name="medical-outline" size={48} color="#ccc" />
            <Text style={styles.emptyStateText}>No Medications Scheduled</Text>
            <Link href="/medications/add">
              <TouchableOpacity style={styles.addMedicationButton}>
                <Text style={styles.addMedicationButtonText}>
                  Add Medication
                </Text>
              </TouchableOpacity>
            </Link>
          </View>
        ) : (
          [].map((medications, index) => {
            // const taken = medications
            return (
              <View key={index} style={styles.doseCard}>
                <View
                  style={[
                    styles.doseBadge, //{ backgroundColor: medications.color }
                  ]}
                >
                  <Ionicons name="medical-outline" size={24} />
                </View>
                <View style={styles.doseInfo}>
                  <View>
                    <Text style={styles.medicineName}>name</Text>
                    <Text style={styles.doseInfo}>dosage</Text>
                  </View>
                  <View style={styles.doseTime}>
                    <Ionicons name="time-outline" size={16} color="#ccc" />
                    <Text>Time</Text>
                  </View>
                </View>
                {true ? (
                  <View style={styles.takeDoseButton}>
                    <Ionicons
                      name="checkmark-circle-outline"
                      size={24}
                      color="#4caf50"
                    />
                    <Text style={styles.takeDoseButtonText}>
                      Medication Taken
                    </Text>
                  </View>
                ) : (
                  <View>
                    <TouchableOpacity style={styles.takeDoseButton}>
                      <Text style={styles.takeDoseButtonText}>Take</Text>
                    </TouchableOpacity>
                  </View>
                )}
              </View>
            );
          })
        )}
      </View>
      <Modal visible={false} transparent={true} animationType="slide">
        <View style={styles.modalOverlay}>
          <View style={styles.modalContent}>
            <Text style={styles.modalTitle}>Notification</Text>
            <TouchableOpacity style={styles.modalCloseButton}>
              <Ionicons name="close" size={24} color="black" />
            </TouchableOpacity>
          </View>
        </View>
        {[].map((medication, index) => (
          <View style={styles.notificationItem} key={index}>
            <View style={styles.notificationIcon}>
              <Ionicons name="medical-outline" size={24} color="#4CAF50" />
            </View>
            <View style={styles.notificationContent}>
              <Text style={styles.notificationTitle}>medication name</Text>
              <Text style={styles.notificationMessage}>medication dosage</Text>
              <Text style={styles.notificationTime}>medication time</Text>
            </View>
          </View>
        ))}
      </Modal>
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
  sectionHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    marginBottom: 10,
  },
  seeAllButton: {
    fontSize: 14,
    color: "#2E7D32",
    fontWeight: "600",
  },
  emptyStateText: {
    fontSize: 16,
    color: "#666",
    marginTop: 10,
    marginBottom: 20,
  },
  addMedicationButton: {
    backgroundColor: "#4CAF50", // yeşilimsi güzel bir renk (değiştirilebilir)
    paddingVertical: 10,
    paddingHorizontal: 24,
    borderRadius: 24, // oval görünüm
    alignItems: "center",
    justifyContent: "center",
    shadowColor: "#000",
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
  },
  addMedicationButtonText: {
    color: "white",
    fontSize: 16,
    fontWeight: "600",
  },
  doseCard: {
    flexDirection: "row",
    alignItems: "center",
    backgroundColor: "white",
    borderRadius: 16,
    padding: 16,
    marginBottom: 12,
    shadowColor: "#000",
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.05,
    shadowRadius: 8,
    elevation: 3,
  },
  doseBadge: {
    width: 50,
    height: 50,
    borderRadius: 25,
    justifyContent: "center",
    alignItems: "center",
    marginRight: 16,
  },
  doseInfo: {
    flex: 1,
    justifyContent: "center",
  },
  medicineName: {
    fontSize: 16,
    fontWeight: "600",
    color: "#333", // koyu ama siyah değil
    marginBottom: 4,
  },
  doseTime: {
    flexDirection: "row",
    alignItems: "center",
    gap: 6,
  },
  takeDoseButton: {
    flexDirection: "row",
    alignItems: "center",
    backgroundColor: "#E8F5E8",
    paddingHorizontal: 12,
    paddingVertical: 8,
    borderRadius: 20,
    borderWidth: 1,
    borderColor: "#4CAF50",
    gap: 6,
  },
  takeDoseButtonText: {
    fontSize: 12,
    color: "#4CAF50",
    fontWeight: "600",
  },

  emptyStateContainer: {
    alignItems: "center",
    paddingVertical: 40,
    backgroundColor: "#f8f8f8",
    borderRadius: 16,
    marginBottom: 20,
  },
  medicationList: {
    backgroundColor: "#f8f8f8",
    borderRadius: 16,
    padding: 20,
    alignItems: "center",
  },
  modalOverlay: {
    flex: 1,
    backgroundColor: "rgba(0, 0, 0, 0.5)",
    justifyContent: "flex-end",
  },
  modalContent: {
    backgroundColor: "white",
    borderTopLeftRadius: 16,
    borderTopRightRadius: 16,
    padding: 20,
    paddingBottom: 40,
    height: "50%",
  },
  modalHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    marginBottom: 20,
  },
  modalTitle: {
    fontSize: 18,
    fontWeight: "600",
    color: "#333",
  },
  modalCloseButton: {
    padding: 8,
    backgroundColor: "#f0f0f0",
    borderRadius: 12,
  },
  notificationItem: {
    flexDirection: "row",
    alignItems: "center",
    paddingVertical: 12,
    borderBottomWidth: 1,
    borderBottomColor: "#e0e0e0",
  },
  notificationIcon: {
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: "#e0f7fa",
    justifyContent: "center",
    alignItems: "center",
    marginRight: 12,
  },
  notificationContet: {
    flex: 1,
  },
  notificationText: {
    fontSize: 16,
    color: "#333",
    marginBottom: 4,
  },
  notificationTime: {
    fontSize: 12,
    color: "#999",
  },
  notificationMessage: {
    fontSize: 14,
    color: "#666",
    marginBottom: 4,
  },
  notificationContent: {
    flex: 1,
  },
  notificationTitle: {
    fontSize: 16,
    fontWeight: "600",
    color: "#333",
    marginBottom: 4,
  },
});
