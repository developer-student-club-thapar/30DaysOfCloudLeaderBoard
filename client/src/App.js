
import gdsc from "./assets/media/gdsc-banner.svg";
import cloud from './assets/media/cloud-icon.png';
import leaderboard from './assets/media/leaderboard.png';
import Leaderboard from "./components/Leaderboard";

function App() {
  return (
    <>
      <header>
        <div className="header">
          <img src={gdsc} style={{
            width:'400px',
            maxWidth:'80vw',
            alignSelf:'flex-start'
            }} alt='Google Developers Student Clud'/>
          <div className="title">
            <img src={cloud} alt='Google Cloud Logo'/>
            <h1>#30DayGCPChallenge</h1>
            <h2>DSC TIET, Patiala</h2>
          </div>
        </div>
      </header>
      <div className="leaderboardTitle">
            <h1>Leaderboard</h1>
            <img src={leaderboard} alt='badge'/>
      </div>
      <Leaderboard/>

      {/* <footer>
          <img src={brackets} style ={{width:'200px'}}/>
      </footer> */}
    </>
  );
}

export default App;
