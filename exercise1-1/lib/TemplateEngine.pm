use strict;
use warnings;
use utf8;
use FindBin::libs;

package TemplateEngine;

sub new {
	my ($class, %file_hash) = @_;
	my $data = {%file_hash};
	
	return bless $data, $class;
}


# html書き換えて出力
sub render {
	my ($self, $hash) = @_;
	
	# 引数のハッシュをデリファレンス
	my %hash = %$hash;
	my $title = $hash{'title'};
	my $content = $hash{'content'};
	my @escape_arr = {$title, $content};
	
	# エスケープ
	my @escaped = &escape (@escape_arr);
	
	# ファイルオープン
	my $file_str = $self -> {file};
	open( FI, "<:encoding(utf8)", $file_str) or die "Cannot open ".$self->{file}.$!;
		my @html = <FI>;
	close (FI);
	
	# ループさせてテンプレhtml書き換え
	foreach my $line (@html) {
		if ($line =~/title/) {
			$line =~ s/{%\s*title\s*%}/$title/g;
		}
		elsif ($line =~/content/) {
			$line =~ s/{%\s*content\s*%}/$content/g;
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
	foreach my $str ($_[0]) {
		$str =~ s/&/&amp;/g;
		$str =~ s/</&lt;/g;
		$str =~ s/>/&gt;/g;
		$str =~ s/\"/&quot;/g;
		$str =~ s/\'/&#39;/g; 
		
		return($str);
	}
}

1;