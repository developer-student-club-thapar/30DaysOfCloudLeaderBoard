import '../assets/css/Leaderboard.css';
import crown from '../assets/media/crown.jpeg';

const Row=(props)=>{
    
    return(
        
        <tr>
            <td>{props.data.rank}
            {
                props.data.total_score===props.maxScore?<img src={crown} className="crown" alt="crown"/>:null
            }
            </td>
            <td><a href={props.data.qwikLabURL} target='_blank' className="name">
                <img src={props.data.profile_image} alt="pfp" className="pfp"/>
                <span>
                {props.data.name}
                </span>
                </a></td>
            <td>{props.data.total_score}</td>
            <td>{props.data.track1_score}</td>
            <td>{props.data.track2_score}</td>
        </tr>
        
    );
}

export default Row;