import gdsc from "../assets/media/gdsc-banner.svg";
import cloud from '../assets/media/cloud-icon.png';
import brackets from "../assets/media/brackets.png";


const Header=()=>
{
    return(
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
    );
}
export default Header;