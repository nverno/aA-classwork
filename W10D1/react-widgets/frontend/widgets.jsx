import React from 'react';
import ReactDOM from 'react-dom';
import Clock from './clock';
import Tabs from './tabs';
import Weather from './weather';
import Autocomplete from './autocomplete';

const names = [
  'rick',
  'morty',
  'jerry',
  'summer',
  'jessica',
  'ethan',
  'brad',
  'nancy',
];

const Root = () => {
  const tabs = [
    { title: 'one', content: 'This is the first' },
    { title: 'two', content: 'This is the second' },
    { title: 'three', content: 'balbalalkaka' },
  ];

  return (
    <>
      <Clock />
      <Tabs tabs={tabs} />
      <Weather />
      <Autocomplete list={names} />
    </>
  );
};

document.addEventListener('DOMContentLoaded', () => {
  const root = document.getElementById('root');
  ReactDOM.render(<Root />, root);
});
