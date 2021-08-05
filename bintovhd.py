import sys


'''
@ author : bszy
@ date : 2021-08-05 21-30-07
@ param1 source vhd file
@ param2 source bin file
Is's for assembly learner to read bin file and insert it into vhd file.
It can run with 
'''
def main():
	vhd_file = sys.argv[1]
	bin_file = sys.argv[2]
	buf = ""
	with open(bin_file,"rb") as fd:
		buf = fd.read()
	with open(vhd_file,"r+b") as fd:
		fd.write(buf)
	print("[*] Write vhd file successfully")
if __name__ == '__main__':
	main()