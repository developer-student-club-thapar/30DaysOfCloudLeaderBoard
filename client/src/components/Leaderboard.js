import '../assets/css/Leaderboard.css';
import {useEffect, useState} from 'react';
import axios from 'axios';
import Row from './Row';

const Leaderboard=()=>
{
    const [members, setMembers] = useState([])
    async function getLeaderboard()
    {
        const response = await axios.get('https://gcloud.servatom.com/');
        setMembers(response.data);
    }

    useEffect(()=>{
        getLeaderboard();
    },[])
    
    let rank=1;
    return(
        <div className="leaderboard">
            <table id="leaderboard-table">
              <thead>
                  <tr>
                    <th scope="col">Rank</th>
                    <th scope="col">Name</th>
                    <th scope="col">Total Score</th>
                    <th scope="col">Track-1 Score</th>
                    <th scope="col">Track-2 Score</th>
                  </tr>
              </thead>
              <tbody>
                {
                  members.map((member)=>{
                      return(
                        <Row key={rank+1} rank={rank++} data={member}/>
                      );
                  })
                }
              </tbody>
            
            </table>
        </div>
      );
}

export default Leaderboard;