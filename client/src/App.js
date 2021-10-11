import leaderboard from './assets/media/leaderboard.png';
import Leaderboard from "./components/Leaderboard";
import Header from './components/Header';
import Footer from './components/Footer';

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

      <footer>
        <Footer/>
      </footer>
    </>
  );
}

export default App;
