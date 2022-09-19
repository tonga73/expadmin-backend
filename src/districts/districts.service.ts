import { Injectable } from '@nestjs/common';
import { CreateDistrictDto } from './dto/create-district.dto';
import { UpdateDistrictDto } from './dto/update-district.dto';

import { District, Prisma } from '@prisma/client';
import { PrismaService } from '../prisma.service';

@Injectable()
export class DistrictsService {
  constructor(private prisma: PrismaService) {}

  create(data: Prisma.DistrictCreateInput): Promise<District> {
    return this.prisma.district.create({
      data,
    });
  }

  async findAll(params: {
    skip?: number;
    take?: number;
    cursor?: Prisma.DistrictWhereUniqueInput;
    where?: Prisma.DistrictWhereInput;
    orderBy?: Prisma.DistrictOrderByWithRelationInput;
  }): Promise<District[]> {
    const { skip, take, cursor, where, orderBy } = params;
    return this.prisma.district.findMany({
      skip,
      take,
      cursor,
      where,
      orderBy,
    });
  }

  findOne(
    districtWhereUniqueInput: Prisma.DistrictWhereUniqueInput,
  ): Promise<District | null> {
    return this.prisma.district.findUnique({
      where: districtWhereUniqueInput,
      include: {
        courts: true,
      },
    });
  }

  update(id: number, updateDistrictDto: UpdateDistrictDto): Promise<District> {
    return this.prisma.district.update({
      data: updateDistrictDto,
      where: { id },
    });
  }

  remove(where: Prisma.DistrictWhereUniqueInput): Promise<District> {
    return this.prisma.district.delete({
      where,
    });
  }
}
