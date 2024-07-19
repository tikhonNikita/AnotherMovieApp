import React from 'react';
import {HomeScreen} from './src/HomeScreen';
import {NavigationContainer} from '@react-navigation/native';
import {createBottomTabNavigator} from '@react-navigation/bottom-tabs';
import {FavoritesScreen} from './src/FavoritesScreen';
import MaterialIcons from 'react-native-vector-icons/MaterialCommunityIcons';
import {RouteProp} from '@react-navigation/native';

const Tab = createBottomTabNavigator();

type TabBarIconProps = {
  color: string;
  size: number;
};

type ScreenOptionsProps = {
  route: RouteProp<Record<string, object | undefined>, string>;
};
const iconMap: {[key: string]: string} = {
  Home: 'home-variant-outline',
  Favorites: 'heart',
};

const getIconName = (routeName: string): string => iconMap[routeName] || '';

const getTabBarIcon =
  (route: ScreenOptionsProps['route']) =>
  ({color, size}: TabBarIconProps) => {
    const iconName = getIconName(route.name);
    return <MaterialIcons name={iconName} size={size} color={color} />;
  };

const App: React.FC = () => {
  return (
    <NavigationContainer>
      <Tab.Navigator
        screenOptions={({route}) => ({
          tabBarIcon: getTabBarIcon(route),
          tabBarActiveTintColor: '#007aff',
          tabBarInactiveTintColor: 'gray',
        })}>
        <Tab.Screen name="Home" component={HomeScreen} />
        <Tab.Screen name="Favorites" component={FavoritesScreen} />
      </Tab.Navigator>
    </NavigationContainer>
  );
};

export default App;
