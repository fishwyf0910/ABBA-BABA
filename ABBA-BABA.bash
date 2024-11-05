## phasing
java -jar /home/wangyf/miniconda3/envs/beagle/share/beagle-5.2_21Apr21.304-0/beagle.jar \
gt=/data01/wangyf/project2/CyprinusCarpio/9.snp/raw.indel5.biSNP.QUAL30.QD3.FS30.MQ55.SOR3.MQRS-5.RPRS-5.PASS.maxmiss0.05.AF0.05.10-3ClusterFilter.vcf.gz \
out=phasing nthreads=20

## https://github.com/simonhmartin/tutorials/blob/master/ABBA_BABA_windows

#得到基因型文件，--minQual 最小质量值为30（与过滤参数一致），flag=DP min=4 max=50是指测序深度为4-50.
python /data01/wangyf/software/dtest/genomics_general-master/VCF_processing/parseVCF.py -i /data01/wangyf/project2/CyprinusCarpio/9.newsnp/raw.indel5.biSNP.QUAL30.QD3.FS20.MQ55.SOR4.MQRS-5.RPRS-5.PASS.GQ5.PASS.maxmiss0.05.AF0.05.10-3ClusterFilter.vcf.gz --skipIndels --minQual 30 --gtf flag=DP min=4 max=50 -o input.geno.gz

python /data01/wangyf/software/dtest/genomics_general-master/ABBABABAwindows.py -g input.geno.gz -f phased -o mix-pi/KOI-HB-HLJ.csv.gz -P1 KOI -P2 HB -P3 HLJ -O outgroup --popsFile mix-pi/pop-KOI-HB-HLJ.txt -w 100000 -m 25 -T 4

#筛选掉D<0以及D>0,fd>1的行，提出第1，2，10列
zcat KOI-HB-HLJ.csv.gz | awk -F',' '$9 > 0 && $10 < 1' | awk -F, '{printf "%s\t%s\t%s\n", $1, $2, $10}' > KOI-HB-HLJ.plot
