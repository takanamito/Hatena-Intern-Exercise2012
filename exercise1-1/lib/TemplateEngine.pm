use strict;
use warnings;
use utf8;
use FindBin::libs;

package TemplateEngine;

# html用の配列
our @html = {};
our @escape_arr = {};

# htmlファイルパスから中身を呼び出す
sub new {
	my @hikisu = @_;
	
	my $pkg = $hikisu[0];	# package名
	my $file_str = $hikisu[2];	# htmlのファイルパス
	
	open( FI, "<:encoding(utf8)", $file_str) or die;
		@html = <FI>;
	close (FI);
	
	return $pkg;
}


# html書き換えて出力
sub render {
	my ($name, $hash) = @_;
	my %hash = %$hash;	# ハッシュをデリファレンス
		
	my $title = $hash{'title'};
	my $content = $hash{'content'};
	@escape_arr = {$title, $content};
	
	# エスケープ
	my @escaped = &escape (@escape_arr);
	
	# ループさせてhtml書き換え
	foreach my $line (@html) {
		if ($line =~/title/) {
			$line =~s/{% title %}/$title/;
		}
		elsif ($line =~/content/) {
			$line =~s/{% content %}/$content/;
		}
	}
	
	# output.htmlを出力
#	open (NEWFILE, ">:encoding(utf8)", "output.html");
#	print NEWFILE @html;
#	close (NEWFILE);

	return @html;
}


# エスケープ用サブルーチン
sub escape {
	foreach my $str (@escape_arr) {
		$str =~ s/&/&amp;/g;
		$str =~ s/</&lt;/g;
		$str =~ s/>/&gt;/g;
		$str =~ s/\"/&quot;/g;
		$str =~ s/\'/&#39;/g; 
		
		return($str);
	}
}

1;