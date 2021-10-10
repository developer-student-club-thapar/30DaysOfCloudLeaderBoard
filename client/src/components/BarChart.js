import {Bar} from 'react-chartjs-2';

const BarChart=(props)=>
{
    const data=
    {

        labels: props.scores,
        datasets: [
            {
                label: 'Number of people having these Total Points',
                fill: false,
                lineTension: 0.5,
                backgroundColor: 'rgb(216,81,64)',
                borderColor: 'rgb(216,81,64)',
                borderWidth: 2,
                data: props.total
            },
            {
                label: 'Number of people having these Track 1 Points',
                fill: false,
                lineTension: 0.5,
                backgroundColor: 'rgb(242, 191, 66)',
                borderColor: 'rgb(242, 191, 66)',
                borderWidth: 2,
                data: props.track1
            },
            {
                label: 'Number of people having these Track 2 Points',
                fill: false,
                lineTension: 0.5,
                backgroundColor: 'rgb(89, 166, 92)',
                borderColor: 'rgb(89, 166, 92)',
                borderWidth: 2,
                data: props.track2
            }
            ]
    };

    let delayed;
    return(
        <div className="linechart">
            <Bar
            data={data}
            options={{
                title:{
                display:true,
                text:'People per points',
                fontSize:20
                },
                legend:{
                display:true,
                position:'top'
                },
                animation: 
                {
                    onComplete: () => {
                      delayed = true;
                    },
                    delay: (context) => {
                      let delay = 0;
                      if (context.type === 'data' && context.mode === 'default' && !delayed) {
                        delay = context.dataIndex * 300 + context.datasetIndex * 100;
                      }
                      return delay;
                    }
                } 
            }}
            />
        </div>
    )
}

export default BarChart;