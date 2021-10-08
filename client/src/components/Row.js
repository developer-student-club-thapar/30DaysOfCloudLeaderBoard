import '../assets/css/Leaderboard.css';

const Row=(props)=>{
    return(
        
        <tr>
            <td>{props.rank}</td>
            <td className="name"><a href={props.data.qwikLabURL} target='_blank'>{props.data.name}</a></td>
            <td>{props.data.total_score}</td>
            <td>{props.data.track1_score}</td>
            <td>{props.data.track2_score}</td>
        </tr>
        
    );
}

export default Row;