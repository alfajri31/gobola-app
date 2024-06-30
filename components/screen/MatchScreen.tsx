import { ActivityIndicator, FlatList, RefreshControl, Text, View } from "react-native";
import React, { useState } from "react";
import { MatchItem } from "../../interface/MatchItem.ts";


export function MatchScreen() {
  const [refreshing, setRefreshing] = useState(false);
  const page = 0;
  const pageSize = 5;
  const data: MatchItem[] = [
    { id: '1', title: 'Match 1' },
    { id: '2', title: 'Match 2' },
    { id: '3', title: 'Match 3' },
    { id: '4', title: 'Match 4' },
    { id: '5', title: 'Match 5' },
    { id: '6', title: 'Match 6' },
    { id: '7', title: 'Match 7' },
    { id: '8', title: 'Match 8' },
    { id: '9', title: 'Match 9' },
    { id: '10', title: 'Match 10' },
    { id: '11', title: 'Match 11' },
    { id: '12', title: 'Match 12' },
    { id: '13', title: 'Match 13' },
    { id: '14', title: 'Match 14' },
    { id: '15', title: 'Match 15' },
    { id: '16', title: 'Match 16' },
    { id: '17', title: 'Match 17' },
    { id: '18', title: 'Match 18' },
    { id: '19', title: 'Match 19' },
    { id: '20', title: 'Match 20' },
    { id: '21', title: 'Match 21' },
    { id: '22', title: 'Match 22' },
    { id: '23', title: 'Match 23' },
    { id: '24', title: 'Match 24' },
    { id: '25', title: 'Match 25' },
    { id: '26', title: 'Match 26' },
    { id: '27', title: 'Match 27' }
  ];

  const handleRefresh = () => {
    setRefreshing(true);
    setTimeout(() => setRefreshing(false), 1000);
  };

  const renderItem = ({ item }: { item: MatchItem })=> (
    <View style={
      {
        backgroundColor: 'black',
        padding: 80,
      }
    }>
      <Text>{item.title}</Text>
    </View>
  );

  const startIndex = page * pageSize;
  const endIndex = page + pageSize;
  const paginatedData = data.slice(startIndex, endIndex);
  const [loadingMore, setLoadingMore] = useState(true);
  return (
    <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
      <FlatList
        data={paginatedData}
        renderItem={renderItem}
        keyExtractor={item => item.id}
        refreshControl={
          <RefreshControl refreshing={refreshing} onRefresh={handleRefresh} />
        }
        ListFooterComponent={
          loadingMore ? <ActivityIndicator size="large" color="#0000ff" /> : null
        }
      />
    </View>
  );
}
