Vim�UnDo� yb�B�N#�w��m�?�ں���ŵ�y#��   7       1          )       '   )   )    SK��   
 _�                             ����                                                                                                                                                                                                                                                                                                                                                             SKʑ     �       &       5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             SKʬ     �         &      " Creation	  : 5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             SKʰ    �         &    �                " Creation	  : date5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             SKʸ     �       $   '      " �       "   &    5�_�      	             #       ����                                                                                                                                                                                                                                                                                                                                                             SK��     �   "   $   )      "	- If not, from th5�_�      
           	   !   #    ����                                                                                                                                                                                                                                                                                                                                                             SK��     �       "   )      )" " Get the appropriate docset name from:5�_�   	              
   "       ����                                                                                                                                                                                                                                                                                                                                                             SK��     �   !   #   )      "	- The 'filetype' option.5�_�   
                 "       ����                                                                                                                                                                                                                                                                                                                                                             SK��     �   !   #   )      "	-  fromThe 'filetype' option.5�_�                    "       ����                                                                                                                                                                                                                                                                                                                                                             SK��     �   !   #   )      "	- fromThe 'filetype' option.5�_�                    "       ����                                                                                                                                                                                                                                                                                                                                                             SK��     �   !   #   )      "	- FromThe 'filetype' option.5�_�                    "   	    ����                                                                                                                                                                                                                                                                                                                                                             SK��    �   !   #   )       "	- From  the 'filetype' option.5�_�                    #       ����                                                                                                                                                                                                                                                                                                                                                             SK��     �   #   &   *      "	�   #   %   )    5�_�                    %       ����                                                                                                                                                                                                                                                                                                                                                             SK�    �   $   &   +      function s:GetDocsetName()5�_�                    %       ����                                                                                                                                                                                                                                                                                                                                                             SK�.     �   %   '   ,      	�   %   '   +    5�_�                    &       ����                                                                                                                                                                                                                                                                                                                                                             SK�3     �   %   '   ,      	if ()5�_�                    &       ����                                                                                                                                                                                                                                                                                                                                                             SK�8     �   %   '   ,      	if (&filetype == '')5�_�                    &       ����                                                                                                                                                                                                                                                                                                                                                             SK�B     �   %   '   ,      	if (&filetype == '')5�_�                    &       ����                                                                                                                                                                                                                                                                                                                                                             SK�D     �   %   )   ,      	if (&filetype != '')5�_�                    (   	    ����                                                                                                                                                                                                                                                                                                                                                             SK˕     �   '   )   .      		else if 5�_�                    &   	    ����                                                                                                                                                                                                                                                                                                                                                             SK˙     �   %   '   /      	�   %   '   .    5�_�                    &       ����                                                                                                                                                                                                                                                                                                                                                             SK˪     �   %   '   /      	let s:fileExtension = expand()5�_�                    &       ����                                                                                                                                                                                                                                                                                                                                                             SK˪    �   %   '   /      !	let s:fileExtension = expand("")5�_�                    #       ����                                                                                                                                                                                                                                                                                                                                                             SK˷    �   "   $   /      "	- If not, from the extension.5�_�                    '       ����                                                                                                                                                                                                                                                                                                                                                             SK��     �   &   (   0      	�   &   (   /    5�_�                    (       ����                                                                                                                                                                                                                                                                                                                                                             SK��     �   '   )   0      	if (&filetype != '')5�_�                    )       ����                                                                                                                                                                                                                                                                                                                                                             SK��     �   (   *   0      		let s:docsetName = &filetype5�_�                    )       ����                                                                                                                                                                                                                                                                                                                                                             SK��    �   (   *   0      		let s:docsetName = s:filetype5�_�                     *   
    ����                                                                                                                                                                                                                                                                                                                                                             SK�     �   )   +   0      	else if ()5�_�      !               *       ����                                                                                                                                                                                                                                                                                                                                                             SK�L     �   )   +   0      	else if (s:fileExtension)5�_�       "           !   *       ����                                                                                                                                                                                                                                                                                                                                                             SK�O     �   )   +   0       	else if (s:fileExtension != '')5�_�   !   #           "   *        ����                                                                                                                                                                                                                                                                                                                                                             SK�P     �   )   ,   0       	else if (s:fileExtension != '')5�_�   "   $           #   +   (    ����                                                                                                                                                                                                                                                                                                                                                             SK�o     �   *   ,   1      ,		let s:docsetName = s:GetDocsetNameFromList5�_�   #   %           $   +   /    ����                                                                                                                                                                                                                                                                                                                                                             SK�q    �   *   ,   1      /		let s:docsetName = s:GetDocsetNameFromTheList5�_�   $   &           %   +   .    ����                                                                                                                                                                                                                                                                                                                                                             SK�     �   +   .   2      		�   +   -   1    5�_�   %   '           &   -       ����                                                                                                                                                                                                                                                                                                                                                             SK̬    �   ,   .   3      			echo ""5�_�   &   (           '   -       ����                                                                                                                                                                                                                                                                                                                                                             SK̳   	 �   -   1   4      		�   -   /   3    5�_�   '   )           (   0   
    ����                                                                                                                                                                                                                                                                                                                                                             SK��     �   0   2   7       �   0   2   6    5�_�   (               )   1   *    ����                                                                                                                                                                                                                                                                                                                                                             SK��   
 �   0   2   7      +command! GetDocName :echo s:GetDocsetName()5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             SK��     �         )      $let s:save_cpoptions =e e &cpoptions5��