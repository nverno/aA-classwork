import React from 'react';

const ItemDetail = ({ item }) => {
  return (
    <ul>
      <li>{item.name}</li>
      <li>Happiness: {item.happiness}</li>
      <li>Price: &#36{item.price}</li>
    </ul>
  );
};

export default ItemDetail;
