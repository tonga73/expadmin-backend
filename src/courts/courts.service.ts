import { Injectable } from '@nestjs/common';
import { CreateCourtDto } from './dto/create-court.dto';
import { UpdateCourtDto } from './dto/update-court.dto';

import { Court, Prisma } from '@prisma/client';
import { PrismaService } from '../prisma.service';

@Injectable()
export class CourtsService {
  constructor(private prisma: PrismaService) {}

  create(data: Prisma.CourtCreateInput): Promise<Court> {
    return this.prisma.court.create({
      data,
    });
  }

  async findAll(params: {
    skip?: number;
    take?: number;
    cursor?: Prisma.CourtWhereUniqueInput;
    where?: Prisma.CourtWhereInput;
    orderBy?: Prisma.CourtOrderByWithRelationInput;
  }): Promise<Court[]> {
    const { skip, take, cursor, where, orderBy } = params;
    return this.prisma.court.findMany({
      skip,
      take,
      cursor,
      where,
      orderBy,
    });
  }

  findOne(
    courtWhereUniqueInput: Prisma.CourtWhereUniqueInput,
  ): Promise<Court | null> {
    return this.prisma.court.findUnique({
      where: courtWhereUniqueInput,
      include: {
        district: true,
        offices: true,
      },
    });
  }

  update(id: number, updateCourtDto: UpdateCourtDto): Promise<Court> {
    return this.prisma.court.update({
      data: updateCourtDto,
      where: { id },
      include: {
        district: true,
      },
    });
  }

  remove(where: Prisma.CourtWhereUniqueInput): Promise<Court> {
    return this.prisma.court.delete({
      where,
    });
  }
}
