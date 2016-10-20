from geopy.distance import vincenty


file = open("part-r-00000-1")

for line in file:
    fields = line.split("\t")

    # print(fields)
    # print(fields[3].split(",")[6], fields[3].split(",")[7])

    details_loc = (fields[3].split(",")[6], fields[3].split(",")[7])
    request_loc = (fields[5].split(",")[6], fields[5].split(",")[7])

    # if '0.0' in details_loc or '0.0' in request_loc or '' in details_loc or '' in request_loc:

    #if vincenty(details_loc, request_loc).miles > 50:
    print(details_loc, request_loc)

    print(vincenty(details_loc, request_loc).miles)

file.close()
