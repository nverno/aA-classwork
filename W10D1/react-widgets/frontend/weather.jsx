import React, { Component } from 'react';

export default class Weather extends Component {
  constructor(props) {
    super(props);
    this.state = {
      weather: null,
    };
  }

  fetchWeather(coords) {
    const xhReq = new XMLHttpRequest();
    const apiKey = '7de803de2109e2485c875847052050cd';
    const lat = coords.latitude;
    const lon = coords.longitude;
    xhReq.open(
      'GET',
      `https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&appid=${apiKey}&units=imperial`,
      true
    );
    const that = this;
    xhReq.onload = function () {
      const resp = JSON.parse(this.response);
      that.setState(
        {
          weather: resp,
        },
        () => console.log(that.state.weather)
      );
    };
    xhReq.send(null);
  }

  componentDidMount() {
    let geo = navigator.geolocation;
    geo.getCurrentPosition(
      (res) => {
        this.fetchWeather(res.coords);
      },
      (err) => console.log(err)
    );
  }

  render() {
    const weather = this.state.weather;
    return (
      <div className="weather">
        <h1>Weather</h1>
        {!weather && <p>Fetching weather...</p>}
        {weather && (
          <>
            <p>{weather.name}</p>
            <p>{weather.main.temp} degrees</p>
          </>
        )}
      </div>
    );
  }
}
