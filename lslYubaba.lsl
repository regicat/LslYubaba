// リスナーハンドルは生成するごとに1から順に振っていくっぽいので0で初期化
integer lh = 0;
key user = NULL_KEY;
 stealName(string name)
 {
             // 名前を奪う
    llSay(PUBLIC_CHANNEL, "フン。" + name + "というのかい。贅沢な名だねぇ。");
    integer len = llStringLength(name);
    integer idx = (integer)llFrand((float)len);
    string newName  = llGetSubString(name, idx, idx);
    llSay(PUBLIC_CHANNEL, "今からお前の名前は" + newName + "だ。いいかい、" + newName + "だよ。分かったら返事をするんだ、" + newName + "!!");
    
 }
default
{
    touch_start(integer total_number)
    {
        key toucher = llDetectedKey(0);
        // 他の人が先にクリックしていた場合
        if(user != NULL_KEY && user != toucher)
        {
            llSay(PUBLIC_CHANNEL, "うるさいねえ、今忙しいんだ。ちょっとそこで待っといで。");
            return;
        }
        // 念のためリスナーが残ってないか調べて残っていたら削除
        if(lh > 0) 
        {
            llListenRemove(lh);
            lh = 0;
        }
        llSay(0, "契約書だよ。そこに名前を書きな。");
        // クリック者のIDをuserに保存
        user = toucher;
        // リスナー生成
        lh = llListen(PUBLIC_CHANNEL, "", user, "");
        // 1分後のタイマーを設定
        llSetTimerEvent(60.0);
    }
    listen(integer channel, string avatarName, key id, string name)
    {
        // タイマー解除
        llSetTimerEvent(0.0);
        
        // 名前を奪う
        stealName(name);
        
        //リスナー消去
        llListenRemove(lh);
        lh = 0;
        
    }
    timer()
    {
        if(user != NULL_KEY)
        {
            stealName("");
        }
        
        // タイマー解除
        llSetTimerEvent(0.0);
        //リスナー消去
        llListenRemove(lh);
        lh = 0;
     }
}