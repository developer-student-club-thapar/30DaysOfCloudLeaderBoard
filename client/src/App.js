import leaderboard from './assets/media/leaderboard.png';
import Leaderboard from "./components/Leaderboard";
import Header from './components/Header';
import Footer from './components/Footer';
import {AiFillAndroid, AiOutlineDownload} from 'react-icons/ai';

function App() {
  return (
    <>
      <header>
        <Header/>
      </header>

      <div className="leaderboardTitle">
            <h1>Leaderboard</h1>
            <img src={leaderboard} alt='badge'/>
      </div>
      
      <Leaderboard/>

      <div className="downloadLink">
          <span>Want to see this leaderboard on the go? Download the Android
          <AiFillAndroid className="icon"/> 
          app here : </span>
          <a href="https://gcloud.servatom.com/app" target="_blank">
              <AiOutlineDownload/><span>Download App</span>
          </a>
      </div>

      <footer>
        <Footer/>
      </footer>
    </>
  );
}

export default App;
