import { ActivityIndicator, FlatList, RefreshControl, Text, View } from "react-native";
import React, { useEffect, useState } from "react";
import { MatchItem, PageItem } from "../../interface/MatchItem.ts";
import auth from "@react-native-firebase/auth";
import messaging from '@react-native-firebase/messaging';
// @ts-ignore
import PushNotification from "react-native-push-notification";

export function MatchScreen() {
  const [firebaseToken, setFirebaseToken] = useState<string | null>(null);
  const [fcmToken,setFcmToken] = useState<string | null>(null);
  const [refreshing, setRefreshing] = useState(false);
  const [loadingMore, setLoadingMore] = useState(true);
  const [fetchMatch,setFetchMatch] =  useState<PageItem>();
  const [apiReloaded,setApiReloaded] = useState(false)
  const page = 0;
  const pageSize = 7;
  const startIndex = page * pageSize;
  const endIndex = page + pageSize;

  //use effect init firebase
  useEffect(() => {
    // Listen for auth state changes
    const subscriber = auth().onAuthStateChanged(async (user) => {
      if (user) {
        // User is signed in, get their token
        user.getIdToken().then(async (token) => {
          setFirebaseToken(token);
          console.log("APP TOKEN :", token)
          const fcmToken = await messaging().getToken();
          setFcmToken(fcmToken);
          console.log("FCM TOKEN :", fcmToken)
        });
      } else {
        try {
          const userCredential = await auth().createUserWithEmailAndPassword(
            "alfajri3112@gmail.com",
            "password123"
          );
          console.log("User created successfully:", userCredential.user.uid);
        } catch (error) {
          console.log(error)
        }
      }
    });
    // Unsubscribe from auth state changes when no longer in use
    return () => subscriber();
  }, [firebaseToken]);
  //use firebase auth
  useEffect(() => {
    // Request permission to receive notifications
    messaging().requestPermission()
      .then(() => {
        console.log('Permission granted');
      })
      .catch((error) => {
        console.log('Permission denied', error);
      });

    // Listen for FCM messages
    const messageListener = messaging().onMessage((message) => {
      // Process your message
      console.log("TEST PUSH",JSON.stringify(message));
    });
    // Unsubscribe from FCM messages when no longer in use
    return () => messageListener();
  }, []);
  //use effect received notification from firebase
  useEffect(() => {
    PushNotification.configure({
      onNotification: function (notification:any) {
        const { message, title, id } = notification;
        let strTitle: string = JSON.stringify(title).split('"').join('');
        let strBody: string = JSON.stringify(message).split('"').join('');
        const key: string = JSON.stringify(id).split('"').join('');
        PushNotification.createChannel(
          {
            channelId: key,
            channelName: "remote messasge",
            channelDescription: "Notification for remote message",
            vibrate: true,
          },
          (created:any) => console.log(`createChannel returned '${created}'`)
        );

        PushNotification.localNotification({
          channelId: key,
          title: strTitle,
          message: strBody,
        });
        console.log('REMOTE NOTIFICATION ==>',title, message, id, notification);
      },
      popInitialNotification: true,
      requestPermissions: true,
      permission: {
        alert: true,
        badge: true,
        sound: true,
        vibrate: true,
        lightColor: '#FF231F7C',
      }
    });
  }, []);

  const data: PageItem | undefined = fetchMatch;
  const paginatedData = data?.data.slice(startIndex, endIndex);
  const handleRefresh = () => {
    setRefreshing(true);
    setApiReloaded(true);
    setTimeout(() => {
      setRefreshing(false);
      setApiReloaded(false);
    }, 1000);
  };
  const renderItem = ({ item } : { item: MatchItem })=> (
    <View style={
      {
        backgroundColor: 'red',
        padding: 50
      }
    }>
      <Text>{item.id}</Text>
    </View>
  );
  return (
    <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
      <Text style={{color:"black"}} selectable={true}>{fcmToken}</Text>
      <FlatList
        data={paginatedData}
        renderItem={renderItem}
        keyExtractor={item => item.id+'-'+Math.random()}
        refreshControl={
          <RefreshControl refreshing={refreshing} onRefresh={handleRefresh} />
        }
        ListFooterComponent={
          loadingMore ? <ActivityIndicator size="large" color='#013A67' /> : null
        }
      />
    </View>
  );
}
