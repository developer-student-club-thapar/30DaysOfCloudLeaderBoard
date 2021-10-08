import gdsc from "./assets/media/gdsc-banner.svg";
import cloud from './assets/media/cloud-icon.png';
import leaderboard from './assets/media/leaderboard.png';
import Leaderboard from "./components/Leaderboard";
import brackets from "./assets/media/brackets.png";

function App() {
  return (
    <>
      <header>
        <div className="header">
          <img src={gdsc} className="gdsc" style={{
            width:'400px',
            maxWidth:'80vw',
            alignSelf:'flex-start'
            }} alt='Google Developers Student Clud'/>
          <div className="title">
            <img src={cloud} className="cloud" alt='Google Cloud Logo'/>
            <h1>#30DayGCPChallenge</h1>
            <h2>DSC TIET, Patiala</h2>
          </div>
          <img src={brackets} alt='Background' className="extra"/>
        </div>
      </header>
      <div className="leaderboardTitle">
            <h1>Leaderboard</h1>
            <img src={leaderboard} alt='badge'/>
      </div>
      <Leaderboard/>

      <footer>
        <div className="footer">
          <img src={brackets} style ={{width:'100px'}}/>
          <h2>Developers Student Club, TIET Patiala</h2>
        </div>
        <small>Made with ❤️by <a href="https://servatom.com" target="_blank">Servatom</a> at DSC Patiala</small>
      </footer>
    </>
  );
}

export default App;
