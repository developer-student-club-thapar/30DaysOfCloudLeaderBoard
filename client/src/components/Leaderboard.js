import '../assets/css/Leaderboard.css';
import {useEffect, useState} from 'react';
import axios from 'axios';
import Row from './Row';
import LineChart from './LineChart';
import BarChart from './BarChart';
import Searchbar from './SearchBar';
import Loader from './Loader';
import localResult from '../finalLeaderboard.json';
import localPfp from '../assets/avatars/leopard.png';

const Leaderboard=()=>
{
    // Line graph data
    const [members, setMembers] = useState([{}]);
    const [names, setNames] = useState([]);
    const [track1, setTrack1] = useState([]);
    const [track2, setTrack2] = useState([]);
    const [total, setTotal] = useState([]);

    // Bar Graph data
    const [scores, setScores] = useState([]);
    const [frequencyTotal, setFrequencyTotal] = useState([]);
    const [frequencyTrack1, setFrequencyTrack1] = useState([]);
    const [frequencyTrack2, setFrequencyTrack2] = useState([]);

    const [isLoading, setIsLoading] = useState(true);
   function getLeaderboard()
    {
        
      try
      {
        const response = axios.get('https://gcloud.servatom.com/');
          
          setIsLoading(false)
          let rank=1;
          let result = response.data.map((person)=>{
            return { ...person, rank:rank++}
          })
          setMembers(result);
          setFilteredList(result)
          fillDatasets(response.data);
      }  
      catch
      {
        // console.log("Api Down");
        setIsLoading(false);
        let rank=1;
        let result = localResult.map((person)=>{

          if(person.profile_image==="https://gcloud.servatom.com/image")
          {
            person.profile_image=localPfp;
          }
          return { ...person, rank:rank++}
        })
        setMembers(result);
        setFilteredList(result)
        fillDatasets(localResult);

      }
    }

    const fillDatasets=(data)=>
    {

        let names=[], total=[], track1=[], track2=[];
        let frequencyTotal=[], frequencyTrack1=[], frequencyTrack2=[], scores=[];
        
        for(let i=0;i<=data[0].total_score;i++)
        {
          scores.push(i);
          frequencyTotal.push(0);
          frequencyTrack1.push(0);
          frequencyTrack2.push(0);
        }
        data.forEach((person)=>
        {
          // Line graph data filling  
          if(person.total_score>2)
            {
              names.push(person.name);
              total.push(person.total_score);
              track1.push(person.track1_score);
              track2.push(person.track2_score);
            }
            
            // Bar graph data filling
            frequencyTotal[person.total_score]++;
            frequencyTrack1[person.track1_score]++;
            frequencyTrack2[person.track2_score]++;
        })
        setNames(names);
        setTotal(total);
        setTrack1(track1);
        setTrack2(track2);
        // console.log(frequencyTotal, frequencyTrack1, frequencyTrack2, scores);

        setScores(scores.slice(1,scores.length));
        setFrequencyTotal(frequencyTotal.slice(1,frequencyTotal.length));
        setFrequencyTrack1(frequencyTrack1.slice(1,frequencyTrack1.length));
        setFrequencyTrack2(frequencyTrack2.slice(1,frequencyTrack2.length));

    }

    useEffect(()=>{
        getLeaderboard();
    },[])

    const [filteredList, setFilteredList] = useState(members);
    const searchHandler=(text)=>
    {
      const filteredList=members.filter((member)=>{
        return member.name.toLowerCase().includes(text.toLowerCase())
      });
      setFilteredList(filteredList);
    }
    
    let max_marks=members[0].total_score;
    return(
        <div className="leaderboard">
          <Searchbar searchHandler={searchHandler}/>
          <div className="tableWrapper">
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
                  !isLoading?
                  filteredList.map((member,index)=>{
                      return(
                        <Row key={index} data={member} maxScore={max_marks}/>
                      );
                  }):null
                }
              </tbody>
            </table>
            {
                isLoading?<Loader/>:null
            }
          </div>
            
            <h3 style={{textAlign:'center',
                        margin:'50px auto 0px'}}>Top Performers</h3>
            <LineChart names={names} track1={track1} track2={track2} total={total}/>
            <h3 style={{textAlign:'center',
                        margin:'70px auto 0px'}}>Number of people per points</h3>
            <BarChart scores={scores} total={frequencyTotal} track1={frequencyTrack1} track2={frequencyTrack2}/>
        </div>
      );
}

export default Leaderboard;