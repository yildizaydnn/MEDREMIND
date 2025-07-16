import { Text, View, StyleSheet, Animated } from 'react-native'
import React, { Component, use } from 'react'
import {Ionicons} from '@expo/vector-icons'
import {useEffect, useRef} from 'react'
import { useRouter } from 'expo-router';

export default function  SplashScreen() {

    const fadeAnim = useRef(new Animated.Value(0)).current;
    const scaleAnim = useRef(new Animated.Value(0.5)).current;
    const router = useRouter();

   
   useEffect(() => {
    Animated.parallel([
   Animated.timing(fadeAnim, {
     toValue: 1,
     duration: 1000,
     useNativeDriver: true
   }),
   Animated.spring(scaleAnim, {
     toValue: 1,
     friction: 2,
     tension: 100,
     useNativeDriver: true
   }),
    ]) .start();

    const timer = setTimeout(() =>{
        router.replace('/auth')

    }, 2000)

    return () => clearTimeout(timer);

}, []);


 

    return (
        <View style={styles.container}>
 <Animated.View 
 
 style={[
    styles.iconContainer,
    {
        opacity: fadeAnim,
        transform: [{scale: scaleAnim}]
    }

 ]}
 
 >
         <Ionicons name='medical' size={100} color='white'/>
            <Text style= {styles.appNAme}>MedRemind</Text>
 </Animated.View>
        
        </View>
    );
}

const styles = StyleSheet.create({
    
    container: {
        flex: 1,
        backgroundColor: '#4CAF50',
        alignItems: 'center',
        justifyContent: 'center'
    },
    iconContainer: {
       alignItems: 'center',
    },
    appNAme: {
        color: 'white',
        fontSize: 30,
        fontWeight: 'bold',
        marginTop: 20,
        letterSpacing: 1

    }
})
  