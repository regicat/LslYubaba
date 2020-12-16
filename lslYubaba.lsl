integer lh;
key user;
default
{
    touch_start(integer total_number)
    {
        llSay(0, "契約書だよ。そこに名前を書きな。");
        
        user = llDetectedKey(0);
        
        lh = llListen(PUBLIC_CHANNEL, "", user, "");
    }
    listen(integer channel, string avatarName, key id, string name)
    {
        llSay(PUBLIC_CHANNEL, "フン。" + name + "というのかい。贅沢な名だねぇ。");
        integer len = llStringLength(name);
        integer idx = (integer)llFrand((float)len);
        string newName  = llGetSubString(name, idx, idx + 1);
        llSay(PUBLIC_CHANNEL, "今からお前の名前は" + newName + "だ。いいかい、" + newName + "だよ。分かったら返事をするんだ、" + newName + "!!");
        llListenRemove(lh);
    }
}
