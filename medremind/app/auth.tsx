import {
  Text,
  View,
  StyleSheet,
  TouchableOpacity,
  Dimensions,
} from "react-native";
import React, { Component, use } from "react";
import { Ionicons } from "@expo/vector-icons";
import { useEffect, useRef, useState } from "react";
import { useRouter } from "expo-router";
import * as LocalAuthentication from "expo-local-authentication";
import { LinearGradient } from "expo-linear-gradient";

const { width } = Dimensions.get("window");

export default function AuthScreen() {
  const [hasBiometrics, setHasBiometrics] = useState(false);
  const [isAuthenticating, setIsAuthenticating] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const router = useRouter();

  useEffect(() => {
    checkBiometrics();
  }, []);
  const checkBiometrics = async () => {
    const hasHardware = await LocalAuthentication.hasHardwareAsync();
    const isEnrolled = await LocalAuthentication.isEnrolledAsync();
    setHasBiometrics(hasHardware && isEnrolled);
  };

  const authenticate = async () => {
    try {
      setIsAuthenticating(true);
      setError(null);

      const hasHardware = await LocalAuthentication.hasHardwareAsync();
      const isEnrolled = await LocalAuthentication.isEnrolledAsync();
      const supportedTypes =
        await LocalAuthentication.supportedAuthenticationTypesAsync();

      //handle supported types

      const auth = await LocalAuthentication.authenticateAsync({
        promptMessage:
          hasHardware && hasBiometrics
            ? "Use face ID or TouchID"
            : "Enter your PIN",
        fallbackLabel: "Use Pin",
        cancelLabel: "Cancel",
        disableDeviceFallback: false,
      });

      if (auth.success) {
        router.replace("/home");
      } else {
        setError("Authentication failed: Please try again.");
      }
    } catch (error) {}
  };

  return (
    <LinearGradient colors={["#4CAF50", "#2E7D32"]} style={styles.container}>
      <View style={styles.content}>
        <View style={styles.iconContainer}>
          <Ionicons name="medical" size={80} color="white" />
        </View>

        <Text style={styles.title}>MedRemind</Text>
        <Text style={styles.subtitle}>Your personal medication reminder</Text>

        <View style={styles.card}>
          <Text style={styles.welcomeText}>Welcome Back!</Text>
          <Text style={styles.instructionText}>
            {hasBiometrics
              ? "Use face ID or TouchID or PIN to access your medications"
              : "Enter your PIN to access your medications"}
          </Text>

          <TouchableOpacity
            style={[styles.button, isAuthenticating && styles.buttonDisabled]}
            onPress={authenticate}
            disabled={isAuthenticating}
          >
            <Ionicons
              name={hasBiometrics ? "finger-print-outline" : "keypad-outline"}
              size={24}
              color={"black"}
              style={styles.buttonIcon}
            />
            <Text style={styles.buttonText}>
              {isAuthenticating
                ? "Verifying..."
                : hasBiometrics
                ? "Use face ID or TouchID"
                : "Enter PIN"}
            </Text>
          </TouchableOpacity>

          {error && (
            <View>
              <Ionicons name="alert-circle" size={20} color="#f44336" />
              <Text style={styles.errorText}>{error}</Text>
            </View>
          )}
        </View>
      </View>
    </LinearGradient>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  content: {
    flex: 1,
    padding: 20,
    justifyContent: "center",
    alignItems: "center",
  },
  iconContainer: {
    width: 120,
    height: 120,
    backgroundColor: "rgba(255, 255, 255, 0.2)",
    borderRadius: 60,
    justifyContent: "center",
    alignItems: "center",
    marginBottom: 20,
  },

  title: {
    fontSize: 24,
    fontWeight: "bold",
    color: "white",
    marginBottom: 10,
    textShadowColor: "rgba(0, 0, 0, 0.2)",
    textShadowOffset: { width: 2, height: 2 },
    textShadowRadius: 4,
  },

  subtitle: {
    fontSize: 18,
    color: "rgba(255, 255, 255, 0.9)",
    marginBottom: 10,
    textAlign: "center",
  },
  card: {
    backgroundColor: "rgb(255, 255, 255)",
    borderRadius: 20,
    padding: 20,
    width: width - 40,
    alignItems: "center",
    shadowColor: "#000",
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.25,
    shadowRadius: 3.84,
    elevation: 5,
  },
  welcomeText: {
    fontSize: 20,
    fontWeight: "bold",
    color: "#333",
    marginBottom: 10,
  },
  instructionText: {
    fontSize: 16,
    color: "#666",
    textAlign: "center",
    marginBottom: 30,
  },
  button: {
    backgroundColor: "#4CAF50",
    padding: 10,
    borderRadius: 12,
    paddingVertical: 10,
    paddingHorizontal: 20,
    width: "100%",
    alignItems: "center",
    flexDirection: "row",
  },
  buttonDisabled: {
    opacity: 0.5,
  },
  buttonText: {
    color: "white",
    fontSize: 16,
    fontWeight: "600",
  },
  errorContainer: {
    flexDirection: "row",
    alignItems: "center",
    marginTop: 10,
    backgroundColor: "#f8d7da",
    padding: 10,
    borderRadius: 8,
    width: "100%",
    justifyContent: "center",
  },
  errorText: {
    color: "#721c24",
    fontSize: 14,
    textAlign: "center",
    marginLeft: 10,
  },
  buttonIcon: {
    marginRight: 10,
  },
});
