var Template = function(input) {
    // この関数を実装してください
    this.html = input.source;
};

Template.prototype = {
    render: function(variables) {
        // この関数を実装してください
        var title_str = variables.title;
        var content_str = variables.content;
        var str = new Array(title_str, content_str);
        
        // htmlエスケープ
        for (var val in str) {
	        str[val] = escape(str[val]);
        }
        
        // リンク処理
        var search_url = str[1].indexOf("http");
        
        if(search_url != -1 ) {
	        str[1] = str[1].replace(/(http:\/\/[\x21-\x7e]+)/gi, "\<a href='$1'>$1<\/a>");
        }
        
        // 置換
        this.html = this.html.replace(/{%\s*title\s*%}/, str[0]);
        this.html = this.html.replace(/{%\s*content\s*%}/, str[1]);
        
        return this.html;
    }
};

// htmlエスケープ用関数
function escape(string) {
	string = string.replace(/&/g, "&amp;");
	string = string.replace(/</g,"&lt;");   
    string = string.replace(/>/g,"&gt;");
    string = string.replace(/"/g, "&quot;");
    string = string.replace(/'/g, "&#039;");
    
    return string;
}