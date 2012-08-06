var Template = function(input) {
    // この関数を実装してください
    var html = input;
    html_str = html.source;
    
    return this;
};

Template.prototype = {
    render: function(variables) {
        // この関数を実装してください
        var title_str = variables.title;
        var content_str = variables.content;
        var value = new Array(title_str, content_str);
        
        // htmlエスケープ
        for (var val in value)
        {
	        value[val] = escape(value[val]);
        }
        
        // 置換
        var output_html = html_str.replace("{% title %}", value[0]);
        output_html = output_html.replace("{% content %}", value[1]);
        
        return output_html;
    }
};

// htmlエスケープ用関数
function escape(string) {
	string = string.replace(/&/g, "&amp;");
	string = string.replace(/</g,"&lt;");    
    string = string.replace(/>/g,"&gt;");
    
    return string;
}