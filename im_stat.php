<?php
header('Access-Control-Allow-Origin:*');
$IM = 'Im.malu.me';
$IM_ROOM = array(
'C1'=>0,
'C2'=>0,
'M1'=>0,
'M2'=>0,
'AI'=>0,
);

$redis = new redis();  
$redis->connect('localhost', 6379);
$result = $redis->auth('REDIS_PASS');
if($result){
        $pipe = $redis->multi(Redis::PIPELINE);
        foreach ($IM_ROOM as $key=>$value) {
                $pipe->lrange($IM.'_'.$key,0,0);  
        }   
        $result = $pipe->exec();
        //var_dump($result);
}        
          
if($result){
        $i=0;
        foreach ($IM_ROOM as $key=>$value) {
                if($result[$i]){
                        $r = explode('-',$result[$i][0]);
                        $IM_ROOM[$key]=$r[0];
                }   
                $i++;
        }   
        //var_dump($IM_ROOM);
}   
$json_result = json_encode($IM_ROOM);
echo $json_result;
//$rlocal->setex($IM,2,$json_result);                                                                                                                     
?>