import '../assets/css/Leaderboard.css';
import {useEffect, useState} from 'react';
import axios from 'axios';
import Row from './Row';
import LineChart from './LineChart';

const Leaderboard=()=>
{
    const [members, setMembers] = useState([]);
    const [names, setNames] = useState([]);
    const [track1, setTrack1] = useState([]);
    const [track2, setTrack2] = useState([]);
    const [total, setTotal] = useState([]);

    async function getLeaderboard()
    {
        const response = await axios.get('https://gcloud.servatom.com/');
        setMembers(response.data);

        fillDatasets(response.data);
    }

    const fillDatasets=(data)=>
    {

        let names=[], total=[], track1=[], track2=[];
        data.forEach((person)=>
        {
            names.push(person.name);
            total.push(person.total_score);
            track1.push(person.track1_score);
            track2.push(person.track2_score);

        })
        setNames(names);
        setTotal(total);
        setTrack1(track1);
        setTrack2(track2);

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
            {
                console.log(total)
            }
            <LineChart names={names} track1={track1} track2={track2} total={total}/>
        </div>
      );
}

export default Leaderboard;