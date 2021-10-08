import '../assets/css/Leaderboard.css';

const Row=(props)=>{
    return(
        
        <tr>
            <td>{props.rank}</td>
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