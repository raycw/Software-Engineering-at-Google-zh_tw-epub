#!/bin/bash

# copy images to current directory
mkdir images
for i in zh-cn/**/images/*; do
    IMAGE=$(basename "$i")
    cp "$i" "images/$IMAGE"
done

# replace footnotes to avoid duplication
mdfiles=(zh-cn/**/*.md)
mkdir mds
for i in ${!mdfiles[@]}; do
    # search and replace footnote with index
    cat "${mdfiles[i]}" | sed -r "s/\[\^([e|c][0-9]*)\]/\[\^\1-$i\]/g" > mds/$(basename ${mdfiles[i]})
done

# ls zh-cn/Chapter-*/*.md | sort -V
pandoc -o swe.epub \
    zh-cn/Preface.md \
    zh-cn/Foreword.md \
    mds/Chapter-1_What_Is_Software_Engineering.md \
    mds/Chapter-2_How_to_Work_Well_on_Teams.md \
    mds/Chapter-3_Knowledge_Sharing.md \
    mds/Chapter-4_Engineering_for_Equity.md \
    mds/Chapter-5_How_to_Lead_a_Team.md \
    mds/Chapter-6_Leading_at_Scale.md \
    mds/Chapter-7_Measuring_Engineering_Productivity.md \
    mds/Chapter-8_Style_Guides_and_Rules.md \
    mds/Chapter-9_Code_Review.md \
    mds/Chapter-10_Documentatio.md \
    mds/Chapter-11_Testing_Overview.md \
    mds/Chapter-12_Unit_Testing.md \
    mds/Chapter-13_Test_Doubles.md \
    mds/Chapter-14_Larger_Testing.md \
    mds/Chapter-15_Deprecation.md \
    mds/Chapter-16_Version_Control_and_Branch_Management.md \
    mds/Chapter-17_Code_Search.md \
    mds/Chapter-18_Build_Systems_and_Build_Philosophy.md \
    mds/Chapter-19_Critique_Googles_Code_Review_Tool.md \
    mds/Chapter-20_Static_Analysis.md \
    mds/Chapter-21_Dependency_Management.md \
    mds/Chapter-22_Large-Scale_Changes.md \
    mds/Chapter-23_Continuous_Integration.md \
    mds/Chapter-24_Continuous_Delivery.md \
    mds/Chapter-25_Compute_as_a_Service.md \
    zh-cn/Afterword.md \
    epub_meta.yaml

# clean up
rm -rf images
rm -rf mds