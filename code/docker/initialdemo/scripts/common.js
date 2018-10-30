function myfuncs() { 
    return [{ func: "printNameByDate()", description: "print repository names after a specified date"}, 
                { func: "myfuncs()", description: "List my functions"}]; 
}

function printNameByDate() {
    return db.github_repos.find({updated_at:{"$gte":"2018-10-22T19:37:23Z"}},{_id:0,name:1}).pretty();
}

myfuncs();
