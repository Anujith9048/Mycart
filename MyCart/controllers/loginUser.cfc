component{

    remote any function checkUser(username,email,password) returnFormat="JSON"{
    local.objUser = createObject("component", "models.loginUser");
        if(trim(len(username)) EQ 0 ||trim(len(email)) EQ 0 || trim(len(password))EQ 0){
            local.error='Please fill all fields';
            return {"result":false ,"msg":local.error};
        }
        else{
            local.checkUser=local.objUser.checkUser(username=username,email=email,password=password);
            if(local.checkUser.result EQ true){
                session.isLog = true;
                session.username =local.checkUser.msg.fldUserName;
                session.userId = local.checkUser.msg.fldUser_ID;
                return {"result":true};
            }
            else{
                local.logUser=local.objUser.logUser(username=username,email=email,password=password);
                if(local.logUser.result EQ true){
                    session.isLog = true;
                    session.username =username;
                    session.userId = local.logUser.userID;
                    return {"result":true};
                }
            }
            
        }
    }


    remote any function logUser(username,email,password) returnFormat="JSON"{
        if(trim(len(username)) EQ 0 ||trim(len(email)) EQ 0 || trim(len(password))EQ 0){
            local.error='Please fill all fields';
            return {"result":false ,"msg":local.error};
        }
        else{
            local.checkUser=local.objUser.logUser(username=username,email=email,password=password);
            if(local.checkUser.recordCount){
                session.isLog = true;
                session.username =local.checkUser.fldUserName;
                session.userId = local.checkUser.fldUser_ID;
                return {"result":true};
            }
            
        }
    }


    remote any function checkLogin(username,email,password) returnFormat="JSON"{
        local.objUser = createObject("component", "models.loginUser");
            if(trim(len(username)) EQ 0 ||trim(len(email)) EQ 0 || trim(len(password))EQ 0){
                local.error='Please fill all fields';
                return {"result":false ,"msg":local.error};
            }
            else{
                local.checkUser=local.objUser.checkUser(username=username,email=email,password=password);
                if(local.checkUser.result EQ true){
                    session.isLog = true;
                    session.username =local.checkUser.msg.fldUserName;
                    session.userId = local.checkUser.msg.fldUser_ID;
                    return {"result":true};
                }
                else{
                    local.logUser=local.objUser.loginUser(username=username,email=email,password=password);
                    if(local.logUser.result EQ true){
                        session.isLog = true;
                        session.username =username;
                        session.userId = local.logUser.userID;
                        return {"result":true};
                    }
                }
                
            }
        }
}